From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/9] remove volatile keyword from clflush.
Date: Thu, 06 Dec 2007 13:11:07 -0800
Message-ID: <4758656B.1000301__16817.6613086418$1196975600$gmane$org@goop.org>
References: 20071204204931.GC32018@elte.hu
	<1196867313972-git-send-email-gcosta@redhat.com>
	<1196867319253-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1196867319253-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> the p parameter is an explicit memory reference, and is
> enough to prevent gcc to being nasty here. The volatile
> seems completely not needed.
>   

The usual reason for these types of "volatiles" is to make type checking
happier, since "volatile void *" is compatible with any argument you
might pass.  IOW, if you pass a plain "char *" then the compiler will
promote it to "volatile char *" and not complain, and passing an already
volatile pointer will be OK too.

The volatile isn't there to modify the generated code in any way.

    J
