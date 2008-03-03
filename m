From: "Amit Shah" <amitshah@gmx.net>
Subject: Re: [PATCH] VIRTIO NET: Enable netpoll interface for netconsole
	logging
Date: Mon, 3 Mar 2008 10:22:55 +0530
Message-ID: <877aabc40803022052p44aa8d26nc2333b7c08126aea__17601.908875122$1204520124$gmane$org@mail.gmail.com>
References: <877aabc40802290254k2ecc559at2a3bc9740cd82ebc@mail.gmail.com>
	<200803031508.18063.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803031508.18063.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 3, 2008 at 9:38 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Friday 29 February 2008 21:54:50 Amit Shah wrote:
>  > Add a new poll_controller handler that the netpoll interface needs.
>  >
>  > This enables netconsole logging from a kvm guest over the virtio
>  > net interface.
>  >
>  > Signed-off-by: Amit Shah <amitshah@gmx.net>
>
>  Wow, does this actually work?

Yes, it does :-)

>  If so, I'll apply it no problems...
>  Rusty.

Thanks.
Amit.

-- 
Amit Shah
http://www.amitshah.net/
