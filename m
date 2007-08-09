From: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: 2.6.22 x86_64 : kernel initial decompression hangs
	on vmware
Date: Thu, 09 Aug 2007 16:28:16 -0700
Message-ID: <46BBA310.6060706@vmware.com>
References: <46A7E606.4030001@oxeva.fr> <46B4A7E4.4030907@vmware.com>
	<46BB7FCC.4040509@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46BB7FCC.4040509-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Virtualization Mailing List <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Jim Mattson <jmattson-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Gabriel Barazer <gabriel-KSe8qvLY914@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>
> We haven't seen any issue with the 2.6.22 boot decompressor.  Which of 
> the four (fs, gs, ldt, or tr) were proving problematic and why?

It was tr that was affecting Workstation, since we boot through normal 
BIOS path, and only a 16-bit task was loaded at this point.

Just to make the state comprehensive, I opted to reload everything.

Zach

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
