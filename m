From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: 2.6.22 x86_64 : kernel initial decompression hangs
	on vmware
Date: Thu, 09 Aug 2007 23:57:48 +0300
Message-ID: <46BB7FCC.4040509@qumranet.com>
References: <46A7E606.4030001@oxeva.fr> <46B4A7E4.4030907@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46B4A7E4.4030907-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
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
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Virtualization Mailing List <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Jim Mattson <jmattson-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Gabriel Barazer <gabriel-KSe8qvLY914@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
>
> Since I was just involved in the boot decompressor for another bug, I 
> took a look at this.  2.6.22 switches it to be 64-bit code.  VT is 
> very picky about what state it can run in.  Not using VT on Intel 
> 64-bit hardware cripples performance, running at far below normal 
> speed, and taking minutes to decompress the kernel, which is nearly 
> instantaneous otherwise.
>
> To get back into VT in this case, not only do we need to load FS and 
> GS, we also need to setup an initial LDT and task.  Can you try the 
> attached patch and see that it does the right thing?
>
> I've also cc'd the KVM developers, as the same problem will affect 
> them, and hopefully the same patch will fix it.
>

We haven't seen any issue with the 2.6.22 boot decompressor.  Which of 
the four (fs, gs, ldt, or tr) were proving problematic and why?



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
