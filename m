From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] avoid ifdefs in desc.h, getting rid of pack_ldt and
	pack_tss
Date: Thu, 13 Dec 2007 22:35:17 +0100
Message-ID: <20071213213517.GA25563__24406.0192759664$1197582015$gmane$org@elte.hu>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>
	<20071213212221.GA16747@elte.hu> <4761A385.1080301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4761A385.1080301@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> Ingo Molnar wrote:
>>
>>> could we _please_ use basic tools as vmlinux size comparison and 
>>> objcompare when unifying, to make sure it's a 100% identity conversion?
>>
>> case in point, the patch claims:
>>
>>>> No functional change is made.
>>
>> but vmlinux before/after size comparison shows:
>>
>>     text    data     bss     dec     hex filename
>>  8802894 1224910 3526656 13554460         ced31c vmlinux.before
>>  8803042 1224910 3526656 13554608         ced3b0 vmlinux.after
>
> Well, "no functional changes" is not quite the same thing as "no 
> object code changes".

yeah, true, but the safest way to ensure no functional changes is to get 
identical object code. In sched-devel.git i include obj comparisons to 
cleanup patches as a self-assurance (and later bughunt helper) to make 
sure a cleanup is really just a cleanup.

also, this patch, at first sight, should result in very similar (perhaps 
even the very same) object code. Not 1.2K larger.

	Ingo
