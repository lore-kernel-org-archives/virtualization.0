From: Ben-Ami Yassour <benami@il.ibm.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
	handling
Date: Thu, 17 Jul 2008 19:56:35 +0300
Message-ID: <1216313795.31546.342.camel@cluwyn.haifa.ibm.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
	 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
	 <4871EB36.5030003@qumranet.com>
	 <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>
	 <48761558.3070703@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <48761558.3070703@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-07-10 at 16:57 +0300, Avi Kivity wrote:
> Ben-Ami Yassour wrote:
> > On Mon, 2008-07-07 at 13:08 +0300, Avi Kivity wrote:
> >   
> >> Amit Shah wrote:
> >>     
> >>> This will be useful for acking irqs of assigned devices
> >>>
> >>>   
> >>>       
> >> And also for improving time drift tracking.
> >>
> >> Please make this more generic by having a list of callbacks.  There 
> >> could also be just one list, rather than one for the ioapic and one for 
> >> the pic as implemented now.
> >>
> >> It may also make sense to filter the irq number before calling the 
> >> callback rather than relying on the callback to ignore uninteresting irqs.
> >>
> >>     
> > Avi,
> >
> > Did you mean something like the patch below?
> >   
> 
> I did, and have something very similar queued.

The notification list might help simplify the assigned device code.
Are you planning to merge the patch you have queued, or should I use the
one that I sent you?

Thanks,
Ben


