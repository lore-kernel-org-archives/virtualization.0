From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/10] xen: use boot protocol to boot xen kernel
Date: Fri, 15 Jun 2007 09:41:29 -0700
Message-ID: <4672C139.602@goop.org>
References: <20070615004818.424726597@goop.org>	
	<20070615005013.609105644@goop.org>
	<acbcf3840706150912k4c80dfaak17260d503a007278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <acbcf3840706150912k4c80dfaak17260d503a007278@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Satya <satyakiran@gmail.com>
Cc: v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Satya wrote:
> hi,
> I was trying to figure out the boot code of mini-os included in the
> Xen-3.1 source distribution. Is it going to change significantly
> because of this new boot protocol? thanks!

No, there's no change for existing Xen kernels.  It only changes if
you're booting from a bzImage format kernel.

    J
