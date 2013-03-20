From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Tue, 19 Mar 2013 18:57:08 -0700
Message-ID: <1363744628.13070.28.camel__24113.3117735901$1363744659$gmane$org@haakon2.linux-iscsi.org>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130319084057.GB24393@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-03-19 at 09:40 +0100, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2013 at 08:34:45AM +0800, Asias He wrote:
> > ---
> >  hw/vhost.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/vhost.c b/hw/vhost.c
> > index 4d6aee3..0c52ec4 100644
> > --- a/hw/vhost.c
> > +++ b/hw/vhost.c
> > @@ -421,10 +421,12 @@ static void vhost_set_memory(MemoryListener *listener,
> >          return;
> >      }
> >  
> > +#if 0
> >      if (dev->started) {
> >          r = vhost_verify_ring_mappings(dev, start_addr, size);
> >          assert(r >= 0);
> >      }
> > +#endif
> 
> Please add a comment to explain why.
> 

Btw, the output that Asias added in the failure case at the behest of
MST is here:

http://www.spinics.net/lists/target-devel/msg04077.html

MST seemed to think it may be a bug in cpu_physical_memory_map, but as
this worked with the original vhost-scsi code it would seem to indicate
something else at fault..

I'll be comparing what the original code did vs. vhost-scsi-pci to track
this down, but any extra ideas to track is down is appreciated.  ;)

--nab
