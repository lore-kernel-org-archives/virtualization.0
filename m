From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Tue, 19 Mar 2013 16:47:25 +0800
Message-ID: <20130319084725.GA8116@hj.localdomain>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

On Tue, Mar 19, 2013 at 09:40:57AM +0100, Stefan Hajnoczi wrote:
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

Apparently, this is just a workaround for testing not for merge.

> --
> To unsubscribe from this list: send the line "unsubscribe target-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Asias
