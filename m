From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/21] [PATCH] unify common parts of processor.h
Date: Tue, 18 Dec 2007 15:00:34 +0100
Message-ID: <20071218140034.GD17470__48668.1098388091$1197986658$gmane$org@elte.hu>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<20071218114504.GA22832@elte.hu> <4767B78A.5030903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4767B78A.5030903@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

>> due to zapping this bit of include/asm-x86/processor_32.h:
>>
>>  -/* Forward declaration, a strange C thing */
>>  -struct task_struct;
>>  -struct mm_struct;
>>
>> 	Ingo
>>
> I'll test it with your config, and repost.

i've pushed out a new iteration of x86.git, which includes 20 out of 
your 21 patches, so please repost relative to that tree.

i have fixed the above problem by adding those 3 lines.

	Ingo
