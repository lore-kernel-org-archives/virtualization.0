From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] avoid ifdefs in desc.h,
	getting rid of pack_ldt and	pack_tss
Date: Thu, 13 Dec 2007 13:26:29 -0800
Message-ID: <4761A385.1080301@zytor.com>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>
	<20071213212221.GA16747@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213212221.GA16747@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> 
>> could we _please_ use basic tools as vmlinux size comparison and 
>> objcompare when unifying, to make sure it's a 100% identity 
>> conversion?
> 
> case in point, the patch claims:
> 
>>> No functional change is made.
> 
> but vmlinux before/after size comparison shows:
> 
>     text    data     bss     dec     hex filename
>  8802894 1224910 3526656 13554460         ced31c vmlinux.before
>  8803042 1224910 3526656 13554608         ced3b0 vmlinux.after
> 

Well, "no functional changes" is not quite the same thing as "no object 
code changes".

	-hpa
