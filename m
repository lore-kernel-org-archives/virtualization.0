From: "Eric Van Hensbergen" <ericvh@gmail.com>
Subject: Re: lack of ->remove in 9p virtio driver
Date: Wed, 23 Jan 2008 21:57:55 -0600
Message-ID: <a4e6962a0801231957l4e183cf0kce36d55fc9e6a92b__17949.9161117294$1201147211$gmane$org@mail.gmail.com>
References: <200801241118.57367.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801241118.57367.rusty@rustcorp.com.au>
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
Cc: lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Jan 23, 2008 6:18 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>     Just cleaning up patches for 2.6.25 merge, and noticed that
> net/9p/trans_virtio.c doesn't have a remove function.  This will crash when
> removing the module (console doesn't have one because it can't really be
> removed).
>

I have some pending merge issues with the 9p trans_virtio driver in my
current 2.6.25 queue.  I'll try to resolve these tomorrow as well as
add a remove function.

             -eric
