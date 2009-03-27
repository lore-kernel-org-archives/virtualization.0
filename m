From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/5] lguest: avoid accidental recycling of pgdir pages
Date: Fri, 27 Mar 2009 09:33:04 -0700
Message-ID: <49CCFFC0.1020904__24268.4306264438$1238171830$gmane$org@goop.org>
References: <200903271022.28863.rusty@rustcorp.com.au>
	<49CC1B1C.3080102@goop.org>
	<200903271154.22450.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200903271154.22450.rusty@rustcorp.com.au>
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
Cc: lguest@ozlabs.org, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Now, I haven't *seen* this happen...
>   

Oh, maybe its because you already zap the shadows on tlb flush, and the 
kernel is careful to tlb flush every pagetable page before freeing...

    J
