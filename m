From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: make config_ops const
Date: Thu, 07 Feb 2013 10:18:33 +1030
Message-ID: <87fw19j966.fsf@rustcorp.com.au>
References: <20130205094244.2993245a@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130205094244.2993245a@nehalam.linuxnetplumber.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Stephen Hemminger <stephen@networkplumber.org> writes:

> It is just a table of function pointers, make it const for cleanliness and security
> reasons.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied.

Cheers,
Rusty.
