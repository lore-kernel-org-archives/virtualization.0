From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 14:48:22 -0700
Message-ID: <4679A0A6.1020200@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798B16.5090407@goop.org> <46798D9B.5000400@codemonkey.ws>
	<46799157.3070805@vmware.com> <467993B1.6000307@goop.org>
	<46799755.8060405@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46799755.8060405-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> If I had a gentoo install,

Yes, but then you'd be a gentoo user. ;)

> I would probably go so far as to want to recompile everything after 
> migration across CPU vendors; things like NMIs, MSRs, thermal controls 
> and sleep states are also vendor dependent and either need to be 
> emulated both ways, re-invented in a new way entirely, or just dropped.

Many of those things are meaningless for a guest to see or control.

> I don't think cross-CPU vendor hot migration is particularly 
> compelling, although it certainly is possible, the payoff doesn't seem 
> worth the implementation cost and you will find a maze of brambly 
> thorns blocking your path.

We see people trying to do it, and for good reasons.  The selling point 
of VMs is that they can install their thingy once, and it becomes 
independent from its hardware environment, to the extent that they can 
update their hardware without having to worry about its effects on their 
guests.  With a stable OS and live migration, its reasonable to consider 
a guest VM undergoing multiple hardware upgrade transitions with no 
downtime.

I think the general approach is to have a compatible<->performance 
slider which disables/enables non-portable features.  Migrating between 
Intel/AMD is just a slightly more extreme point on the continuum of 
allowing people to migrate between different models within one 
manufacturer's line.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
