From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH 3/16] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Thu, 01 Nov 2007 16:07:40 +0000
Message-ID: <C34FAA4C.17CA9%Keir.Fraser__42886.8449329913$1193934198$gmane$org@cl.cam.ac.uk>
References: <4729F133.3060308@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4729F133.3060308@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 1/11/07 15:30, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> Glauber de Oliveira Costa wrote:
>> I in fact have seen bugs with mixed reads and writes to the same cr,
>> (cr4), but adding the volatile
>> flag to the read function seemed to fix it.
> 
> Well, volatile will make a read be repeated rather than caching the
> previous value, but it has no effect on ordering.

volatile prevents the asm from being 'moved significantly', according to the
gcc manual. I take that to mean that reordering is not allowed.

 -- Keir
