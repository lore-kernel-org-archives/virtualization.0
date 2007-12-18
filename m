From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 13/21] [PATCH] change bitwise operations to get a void
 parameter.
Date: Mon, 17 Dec 2007 21:38:57 -0800
Message-ID: <47675CF1.5070008__16907.1840042763$1197956767$gmane$org@zytor.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
	<200712181618.43852.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712181618.43852.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tuesday 18 December 2007 09:52:36 Glauber de Oliveira Costa wrote:
>> This patch changes the bitwise operations in bitops.h to get
>> a void pointers as a parameter. Before this patch, a lot of warnings
>> can be seen. They're gone after it.
> 
> No, this is a backwards step!  These warnings are important for 
> non-arch-specific code: I fought hard to get them made into unsigned longs.
> 
> But I'm happy for this to be applied as is, then I'll grab the git tree, 
> revert it and fix the warnings...
> 

Yes, it's particularly nasty as it'll work fine on littleendian arches, 
and fail on bigendian arches...

	-hpa
