From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] VIRTIO NET: Enable netpoll interface for netconsole
	logging
Date: Mon, 3 Mar 2008 15:08:17 +1100
Message-ID: <200803031508.18063.rusty__32379.034398082$1204517459$gmane$org@rustcorp.com.au>
References: <877aabc40802290254k2ecc559at2a3bc9740cd82ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877aabc40802290254k2ecc559at2a3bc9740cd82ebc@mail.gmail.com>
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
To: Amit Shah <amitshah@gmx.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 29 February 2008 21:54:50 Amit Shah wrote:
> Add a new poll_controller handler that the netpoll interface needs.
>
> This enables netconsole logging from a kvm guest over the virtio
> net interface.
>
> Signed-off-by: Amit Shah <amitshah@gmx.net>

Wow, does this actually work?

If so, I'll apply it no problems...
Rusty.
