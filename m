From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 02/16] adapt lguest launcher to per-cpuness
Date: Wed, 26 Dec 2007 10:35:46 +1100
Message-ID: <200712261035.46939.rusty__22403.9937289946$1198625846$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
	<11981576492807-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576492807-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 December 2007 00:33:42 Glauber de Oliveira Costa wrote:
> +		if (!vcpu_id) {
> +			/*
> +			 * Service input, then unset the BREAK to
> +			 * release the Waker.
> +			 */
> +			handle_input(lguest_fd);
> +			if (pwrite(lguest_fd, args, sizeof(args), 0) < 0)
> +				err(1, "Resetting break");
> +		}

I hate winged comments: those two extra lines, wasted!

Cheers,
Rusty.
