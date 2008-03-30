From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 09/12] xen: make include/xen/page.h portable moving those
	definitions under asm dir.
Date: Sun, 30 Mar 2008 16:41:52 +0300
Message-ID: <47EF98A0.4020903__429.754510014568$1206884660$gmane$org@qumranet.com>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>	<12067044183655-git-send-email-yamahata@valinux.co.jp>
	<47ED57E8.4050506@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47ED57E8.4050506@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, Isaku Yamahata <yamahata@valinux.co.jp>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Isaku Yamahata wrote:
>   
>> The definitions in include/asm/xen/page.h are arch specific.
>> ia64/xen wants to define its own version. So move them to arch specific
>> directory and keep include/xen/page.h in order not to break compilation.
>>
>> Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
>> ---
>>  include/{ => asm-x86}/xen/page.h |    0 
>>  include/xen/page.h               |  169 +-------------------------------------
>>  2 files changed, 1 insertions(+), 168 deletions(-)
>>  copy include/{ => asm-x86}/xen/page.h (100%)
>>
>> diff --git a/include/xen/page.h b/include/asm-x86/xen/page.h
>> similarity index 100%
>> copy from include/xen/page.h
>> copy to include/asm-x86/xen/page.h
>> diff --git a/include/xen/page.h b/include/xen/page.h
>>   
>>     
>
> Is this a magic git-format patch, or is it simply missing 
> asm-x86/xen/page.h?
>
>   

Magic git format.  Look at lines beginning with 'copy' above.

(a better result would have been a move along with a creation of a new 
include/xen/page.h)

-- 
error compiling committee.c: too many arguments to function
