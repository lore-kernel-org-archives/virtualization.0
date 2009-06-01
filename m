From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: find_vqs operation starting at arbitrary index
Date: Tue, 2 Jun 2009 08:53:07 +0930
Message-ID: <200906020853.07559.rusty@rustcorp.com.au>
References: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 1 Jun 2009 05:33:48 pm Amit Shah wrote:
> Hello,
>
> The recent find_vqs operation doesn't allow for a vq to be found at an
> arbitrary location; it's meant to be called once at startup to find all
> possible queues and never called again.
>
> This doesn't work for devices which can have queues hot-plugged at
> run-time. This can be made to work by passing the 'start_index' value as
> was done earlier for find_vq, but I doubt something like the following
> will work. The MSI vectors might need some changing as well.

There's a fundamental conflict here: find_vqs was added so the PCI MSI code 
knows exactly how many virtqueues there are.

So you'll need to sort this out with Michael...

Thanks,
Rusty.
