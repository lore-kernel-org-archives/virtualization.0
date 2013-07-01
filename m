From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Mon, 01 Jul 2013 13:57:44 +0200
Message-ID: <51D16EB8.3050709@redhat.com>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
	<51C16BC2.2060302@redhat.com> <8761x9mrmk.fsf@rustcorp.com.au>
	<51C2CABD.70000@redhat.com> <87ppv3tb3y.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppv3tb3y.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 01/07/2013 01:47, Rusty Russell ha scritto:
> > > 
> > > Mainly because I'm not sure that *all* devices are now safe.  Are they?
> >
> > virtio-scsi's implementation in QEMU is not safe (been delaying that for
> > too long, sorry), but the spec is safe.
> 
> Then if we added a transport feature, we couldn't use it :(

Transport feature bits are still negotiated per device though.
virtio-scsi devices in QEMU would not negotiate that feature.

Paolo

> So I think it needs to be a per-device feature bit.
