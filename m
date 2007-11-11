From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Sun, 11 Nov 2007 19:07:09 +0100
Message-ID: <20071111180709.GG22277__22720.0155648918$1194881783$gmane$org@bingen.suse.de>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<1194633873306-git-send-email-gcosta@redhat.com>
	<1194633878886-git-send-email-gcosta@redhat.com>
	<11946338832681-git-send-email-gcosta@redhat.com>
	<1194633888761-git-send-email-gco!sta@redhat.com>
	<11946338932611-git-send-email-gcosta@redhat.com>
	<1194633898545-git-send-email-gcosta@redhat.com>
	<11946339033567-git-send-email-gcosta@redhat.com>
	<11946339082711-git-send-email-gcosta@redhat.com>
	<11946339142999-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11946339142999-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 09, 2007 at 04:43:05PM -0200, Glauber de Oliveira Costa wrote:
> This patch makes vsmp a paravirt client. It now uses the whole
> infrastructure provided by pvops. When we detect we're running
> a vsmp box, we change the irq-related paravirt operations (and so,
> it have to happen quite early), and the patching function

The PARAVIRT ifdefs look wrong. Surely you don't need them at all
because it cannot work at all without paravirt.

Also you got some white space damage.

And the "EM64T based comment" is wrong because there are AMD based 
vSMPs too.

-Andi
