From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH] avoid ifdefs in desc.h,
	getting rid of pack_ldt and	pack_tss
Date: Thu, 13 Dec 2007 19:51:00 -0200
Message-ID: <4761A944.1050503__40111.2791653306$1197582906$gmane$org@redhat.com>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>
	<20071213212221.GA16747@elte.hu> <4761A385.1080301@zytor.com>
	<20071213213517.GA25563@elte.hu> <4761A6E7.7030602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4761A6E7.7030602@zytor.com>
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
Cc: ak@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, roland@redhat.com, ehabkost@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Ingo Molnar wrote:
>>> Well, "no functional changes" is not quite the same thing as "no 
>>> object code changes".
>>
>> yeah, true, but the safest way to ensure no functional changes is to 
>> get identical object code. In sched-devel.git i include obj 
>> comparisons to cleanup patches as a self-assurance (and later bughunt 
>> helper) to make sure a cleanup is really just a cleanup.
> 
> Of course.  "No object code changes" is a stronger statement, however, 
> not all types of cleanups result in that.
> 
Which is the case here. I wasn't expecting the same object code. Anyway, 
the mistake is explained, and I'm about to send the correct version. 
Sorry again.
