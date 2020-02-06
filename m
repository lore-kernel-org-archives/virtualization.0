From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Thu, 6 Feb 2020 17:17:19 -0500
Message-ID: <20200206171349-mutt-send-email-mst@kernel.org>
References: <20200106054041-mutt-send-email-mst@kernel.org>
 <08ae8d28-3d8c-04e8-bdeb-0117d06c6dc7@de.ibm.com>
 <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
 <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
 <20200120012724-mutt-send-email-mst@kernel.org>
 <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
 <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: eperezma@redhat.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 06, 2020 at 04:12:21PM +0100, Christian Borntraeger wrote:
> 
> 
> On 06.02.20 15:22, eperezma@redhat.com wrote:
> > Hi Christian.
> > 
> > Could you try this patch on top of ("38ced0208491 vhost: use batched version by default")?
> > 
> > It will not solve your first random crash but it should help with the lost of network connectivity.
> > 
> > Please let me know how does it goes.
> 
> 
> 38ced0208491 + this seem to be ok.
> 
> Not sure if you can make out anything of this (and the previous git bisect log)

Yes it does - that this is just bad split-up of patches, and there's
still a real bug that caused worse crashes :)

So I just pushed batch-v4.
I expect that will fail, and bisect to give us
    vhost: batching fetches
Can you try that please?
