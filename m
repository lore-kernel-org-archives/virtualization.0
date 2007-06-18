From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/5] KVM: Add paravirt MMU write support
Date: Mon, 18 Jun 2007 15:38:41 +0300
Message-ID: <46767CD1.7030208@qumranet.com>
References: <4675F462.1010708@codemonkey.ws> <4675F533.40809@codemonkey.ws>
	<46764061.9080705@qumranet.com> <46767B8C.9050001@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46767B8C.9050001-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
>> Hypercalls should return kvm-specific error codes (defined in 
>> include/linux/kvm_para.h), not Linux error codes, as they could be 
>> used in operating systems which have different values for E2BIG and 
>> friends.
>
> If Linux's errnos are stable, we could just use them and let a 
> non-Linux guest define a set of KVM_E2BIG, etc.?  It just seemed 
> pretty ugly to add a bunch of these.

The ugliness will serve to remind us that this is a potentially 
non-Linux path.

In this particular case, the names are not present in guest-visible 
headers, but any other that is made visible must have a 
non-Linux-dependent name, so I don't see why error numbers should be 
treated specially.

-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
