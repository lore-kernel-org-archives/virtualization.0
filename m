From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Char: virtio_console, fix memory leak
Date: Mon, 8 Nov 2010 09:58:22 +1030
Message-ID: <201011080958.23163.rusty__31836.0370737084$1289172657$gmane$org@rustcorp.com.au>
References: <1289034412-24278-1-git-send-email-jslaby@suse.cz>
	<1289034412-24278-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289034412-24278-2-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 6 Nov 2010 07:36:50 pm Jiri Slaby wrote:
> Stanse found that in init_vqs, memory is leaked under certain
> circumstanses (the fail path order is incorrect). Fix that by checking
> allocations in one turn and free all of them at once if some fails
> (some may be NULL, but this is OK).

Good catch, thanks!

I generally prefer the static rather than lazy method of cleanup, but
in this case it's ugly both before and after...

Applied,
Rusty.
