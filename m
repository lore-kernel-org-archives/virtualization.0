From: "Li, Xin B" <xin.b.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops backend (v3)
Date: Thu, 21 Jun 2007 17:26:30 +0800
Message-ID: <B30DA1341B0CFA4893EF8A36B40B5C5D014CC69B@pdsmsx411.ccr.corp.intel.com>
References: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4679EAAF.2060103-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

>As for performance, I've got a few interesting results.  kbuild with a 
>guest using 2G of memory goes from 19 minutes to 12 minutes with the 
>full series applied.  Using 512mb, the build time goes from 10.75 
>minutes to 9 minutes.  For 512mb, native is around 7 minutes so that's 
>pretty close to what Avi had seen.  The more dramatic improvement with 
>large memory guests is probably because of the increased shadow page 
>table activity due to high mem.

Exactly, physical memory above 896M on x86_32 are mapped using temp
mapping, which needs lots of invlpg instructions.
On xen, it needs to wake all the shadows to find the shadow of high mem,
since Xen doesn't use reverse map. On KVM, should be much better.
-Xin

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
