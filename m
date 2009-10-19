From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: INDIRECT and NEXT
Date: Mon, 19 Oct 2009 13:04:20 +1030
Message-ID: <200910191304.20748.rusty@rustcorp.com.au>
References: <20091004143734.GB17578@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091004143734.GB17578@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 5 Oct 2009 01:07:34 am Michael S. Tsirkin wrote:
> Hi!
> I note that chaining INDIRECT descriptors with NEXT
> currently is broken in lguest, because current
> ring index gets overwritten.

I agree this should be fixed, but not quite sure what you're referring to.

I could force indirect and reproduce it, but I figure asking you for details
would be more efficient :)

Thanks!
Rusty.
