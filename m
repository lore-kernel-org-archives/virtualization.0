From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
Date: Thu, 11 Jun 2020 07:30:14 -0400
Message-ID: <20200611072702-mutt-send-email-mst@kernel.org>
References: <20200610113515.1497099-1-mst@redhat.com>
 <20200610113515.1497099-4-mst@redhat.com>
 <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
 <20200610111147-mutt-send-email-mst@kernel.org>
 <CAJaqyWe6d19hFAbpqaQqOPuQQmBQyevyF4sTVkaXKhD729XDkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJaqyWe6d19hFAbpqaQqOPuQQmBQyevyF4sTVkaXKhD729XDkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2020 at 06:18:32PM +0200, Eugenio Perez Martin wrote:
> On Wed, Jun 10, 2020 at 5:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 10, 2020 at 02:37:50PM +0200, Eugenio Perez Martin wrote:
> > > > +/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> > > > + * A negative code is returned on error. */
> > > > +static int fetch_descs(struct vhost_virtqueue *vq)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       if (unlikely(vq->first_desc >= vq->ndescs)) {
> > > > +               vq->first_desc = 0;
> > > > +               vq->ndescs = 0;
> > > > +       }
> > > > +
> > > > +       if (vq->ndescs)
> > > > +               return 1;
> > > > +
> > > > +       for (ret = 1;
> > > > +            ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
> > > > +            ret = fetch_buf(vq))
> > > > +               ;
> > >
> > > (Expanding comment in V6):
> > >
> > > We get an infinite loop this way:
> > > * vq->ndescs == 0, so we call fetch_buf() here
> > > * fetch_buf gets less than vhost_vq_num_batch_descs(vq); descriptors. ret = 1
> > > * This loop calls again fetch_buf, but vq->ndescs > 0 (and avail_vq ==
> > > last_avail_vq), so it just return 1
> >
> > That's what
> >          [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
> > is supposed to fix.
> >
> 
> Sorry, I forgot to include that fixup.
> 
> With it I don't see CPU stalls, but with that version latency has
> increased a lot and I see packet lost:
> + ping -c 5 10.200.0.1
> PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
> >From 10.200.0.2 icmp_seq=1 Destination Host Unreachable
> >From 10.200.0.2 icmp_seq=2 Destination Host Unreachable
> >From 10.200.0.2 icmp_seq=3 Destination Host Unreachable
> 64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=6848 ms
> 
> --- 10.200.0.1 ping statistics ---
> 5 packets transmitted, 1 received, +3 errors, 80% packet loss, time 76ms
> rtt min/avg/max/mdev = 6848.316/6848.316/6848.316/0.000 ms, pipe 4
> --
> 
> I cannot even use netperf.

OK so that's the bug to try to find and fix I think.


> If I modify with my proposed version:
> + ping -c 5 10.200.0.1
> PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
> 64 bytes from 10.200.0.1: icmp_seq=1 ttl=64 time=7.07 ms
> 64 bytes from 10.200.0.1: icmp_seq=2 ttl=64 time=0.358 ms
> 64 bytes from 10.200.0.1: icmp_seq=3 ttl=64 time=5.35 ms
> 64 bytes from 10.200.0.1: icmp_seq=4 ttl=64 time=2.27 ms
> 64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=0.426 ms


Not sure which version this is.

> [root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t TCP_STREAM
> MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> 10.200.0.1 () port 0 AF_INET
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 131072  16384  16384    10.01    4742.36
> [root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t UDP_STREAM
> MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> 10.200.0.1 () port 0 AF_INET
> Socket  Message  Elapsed      Messages
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
> 212992   65507   10.00        9214      0     482.83
> 212992           10.00        9214            482.83
> 
> I will compare with the non-batch version for reference, but the
> difference between the two is noticeable. Maybe it's worth finding a
> good value for the if() inside fetch_buf?
> 
> Thanks!
> 

I don't think it's performance, I think it's a bug somewhere,
e.g. maybe we corrupt a packet, or stall the queue, or
something like this.

Let's do this, I will squash the fixups and post v8 so you can bisect
and then debug cleanly.

> > --
> > MST
> >
