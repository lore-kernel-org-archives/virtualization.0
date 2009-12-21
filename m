From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] vhost: fix use_mm usage
Date: Mon, 21 Dec 2009 21:59:39 +1030
Message-ID: <200912212159.39198.rusty__18634.9098025405$1261395105$gmane$org@rustcorp.com.au>
References: <20091220171608.GA31713@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091220171608.GA31713@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 21 Dec 2009 03:46:08 am Michael S. Tsirkin wrote:
> This patchset fixes an issue, pointed out by Al Viro, in how vhost net
> calls use_mm, Works fine for me, and it's pretty straightforward.  If no
> one sees any issues with it, this will be a good candidate for 2.6.33
> (assuming vhost net itself gets pulled :( ).

No, Linus didn't respond to either pull request.  Either he considers it a
new driver and hence not in a hurry to enter merge window, or there's some
other issue.

I've taken these fixes too, meanwhile.

Thanks,
Rusty.
