From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Problem with multiple hvc consoles via virtio-console
Date: Fri, 26 Mar 2010 10:31:09 +0530
Message-ID: <20100326050109.GK8111__37945.9473224871$1269579824$gmane$org@amit-x200.redhat.com>
References: <20100324153408.GB18581@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100324153408.GB18581@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Mar 24 2010 [21:04:08], Amit Shah wrote:
> Hello,
> 
> When multiple hvc console ports are initialised and used via the
> virtio_console driver, I can interact with only the first console, the
> 2nd one doesn't respond.
> 
> If I call hvc_kick() even if hvc_poll() returns 0, the 2nd console
> becomes responsive.

Actually it's not that fancy: if I login to the first console (hvc0) and
then spawn another one (hvc1), I can't login into hvc1. If I spawn hvc1
before logging into hvc0, I can work with both.

		Amit
