From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Fri, 7 Feb 2020 02:58:32 -0500
Message-ID: <20200207025806-mutt-send-email-mst@kernel.org>
References: <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
 <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
 <20200120012724-mutt-send-email-mst@kernel.org>
 <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
 <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
 <20200206171349-mutt-send-email-mst@kernel.org>
 <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: eperezma@redhat.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 08:47:14AM +0100, Christian Borntraeger wrote:
> Also adding Cornelia.
> 
> 
> On 06.02.20 23:17, Michael S. Tsirkin wrote:
> > On Thu, Feb 06, 2020 at 04:12:21PM +0100, Christian Borntraeger wrote:
> >>
> >>
> >> On 06.02.20 15:22, eperezma@redhat.com wrote:
> >>> Hi Christian.
> >>>
> >>> Could you try this patch on top of ("38ced0208491 vhost: use batched version by default")?
> >>>
> >>> It will not solve your first random crash but it should help with the lost of network connectivity.
> >>>
> >>> Please let me know how does it goes.
> >>
> >>
> >> 38ced0208491 + this seem to be ok.
> >>
> >> Not sure if you can make out anything of this (and the previous git bisect log)
> > 
> > Yes it does - that this is just bad split-up of patches, and there's
> > still a real bug that caused worse crashes :)
> > 
> > So I just pushed batch-v4.
> > I expect that will fail, and bisect to give us
> >     vhost: batching fetches
> > Can you try that please?
> > 
> 
> yes.
> 
> eccb852f1fe6bede630e2e4f1a121a81e34354ab is the first bad commit
> commit eccb852f1fe6bede630e2e4f1a121a81e34354ab
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Oct 7 06:11:18 2019 -0400
> 
>     vhost: batching fetches
>     
>     With this patch applied, new and old code perform identically.
>     
>     Lots of extra optimizations are now possible, e.g.
>     we can fetch multiple heads with copy_from/to_user now.
>     We can get rid of maintaining the log array.  Etc etc.
>     
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
>  drivers/vhost/test.c  |  2 +-
>  drivers/vhost/vhost.c | 39 ++++++++++++++++++++++++++++++++++-----
>  drivers/vhost/vhost.h |  4 +++-
>  3 files changed, 38 insertions(+), 7 deletions(-)
> 


And the symptom is still the same - random crashes
after a bit of traffic, right?

> > 
> 			
