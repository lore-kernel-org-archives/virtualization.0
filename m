From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Fix potential interrupts during alternative patching [was Re: [RFC] Avoid PIT SMP lockups]
Date: Thu, 19 Oct 2006 22:25:47 -0700
Message-ID: <20061020052546.GC8881@kroah.com>
References: <1160170736.6140.31.camel@localhost.localdomain> <453404F6.5040202@vmware.com> <200610170121.51492.caglar@pardus.org.tr> <200610171505.53576.caglar@pardus.org.tr> <453730B7.3040906@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751680AbWJTF4j@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <453730B7.3040906@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 19, 2006 at 01:00:55AM -0700, Zachary Amsden wrote:
> S.??a??lar Onur wrote:
> >17 Eki 2006 Sal 01:21 tarihinde, S.??a??lar Onur ??unlar?? yazm????t??: 
> >  
> >>17 Eki 2006 Sal 01:17 tarihinde, Zachary Amsden ??unlar?? yazm????t??:
> >>    
> >>>My nasty quick patch might not apply - the only tree I've got is a very
> >>>hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious
> >>>enough.
> >>>      
> >>Ok, I'll test and report back...
> >>    
> >
> >Both 2.6.18 and 2.6.18.1 boots without any problem (and of course without 
> >noreplacement workarund) with that patch.
> >
> >Cheers
> >  
> 
> So this patch is an obvious bugfix - please apply, and to stable as 
> well. I'm not sure when this broke, but taking interrupts in the middle 
> of self modifying code is not a pretty sight.

Please send -stable patches to stable@kernel.org, not to me directly (we
are a team and hand off ownership to each other, by sending it to the
alias it makes sure that nothing gets lots in our individual mail
boxes.)

Also, please let stable know when this is upstream, we don't want to
apply it before then.

thanks,

greg k-h
