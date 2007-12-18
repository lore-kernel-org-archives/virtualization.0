From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 21/21] [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 11:49:57 -0200
Message-ID: <4767D005.6040909@redhat.com>
References: <11979320354186-git-send-email-gcosta@redhat.com>
	<11979320401316-git-send-email-gcosta@redhat.com>
	<11979320451308-git-send-email-gcosta@redhat.com>
	<1197932050948-git-send-email-gcosta@redhat.com>
	<11979320551036-git-send-email-gcosta@redhat.com>
	<11979320603229-git-send-email!-gcosta@redhat.com>
	<11979320653161-git-send-email-gcosta@redhat.com>
	<11979320693300-git-send-email-gcosta@redhat.com>
	<20071218131932.GA9457@elte.hu> <20071218133818.GA9941@elte.hu>
	<20071218134018.GA13193@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071218134018.GA13193@elte.hu>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
>> yes, our include file dependencies are a jungle, the differences 
>> between 32-bit and 64-bit are arbitrary in 80% of the cases, but still 
>> there's no reason why this couldnt be done correctly. The patch below 
>> is a quick bandaid that adds the missing bits.
> 
> the bandaid didnt work - so i removed the 21/21 patch for the time 
> being.
I will also have updates for other patches, If you want, you can drop 
the series entirely,
and wait for the new one to come
