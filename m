From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/5] KVM: Add hypercall queue for
	paravirt_ops implementation
Date: Mon, 18 Jun 2007 16:35:59 +0300
Message-ID: <46768A3F.2010202@qumranet.com>
References: <4675F462.1010708@codemonkey.ws> <4675F568.90608@codemonkey.ws>
	<46764B47.5060403@qumranet.com>
	<46767D47.1010104@codemonkey.ws> <46767F98.70109@qumranet.com>
	<46768724.3000509@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46768724.3000509-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>>
>> I did, but using kbuild (a simple 'make' with defconfig), not 
>> kernbench.  I get (elapsed time) 308 sec for kvm and 243 sec for native.
>
> kernbench is a little different.  It does a find over the kernel 
> source tree to attempt to get as much of the kernel in the page cache 
> as possible.  It also uses -j4 by default.
>
>>
>> These numbers are pretty bad.  I'd like to improve them, even without 
>> PV.
>
> I agree.  Do you know what's missing at this point?  There isn't a 
> whole lot of state saving going on for the light weight exit paths for 
> SVM.

The SVM code doesn't even have a lightweight vmexit path.  For every 
vmexit, it does the entire thing, including vmload/vmsave, fpu switch 
(if needed), segment reloading, and msr reloading.  It could use a lot 
of work.

For kbuild vs. kernbench, I suspect that -j4 causes the shadow page 
table cache to thrash.  1024 pages may be enough for a single instance 
but not -j4.  Hopefully replacing the eviction algorithm (currently 
FIFO) will help.  Otherwise we'll need to resize the cache again.

-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
