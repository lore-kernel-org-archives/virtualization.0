From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_pci: add module param to force legacy mode
Date: Mon, 19 Jan 2015 16:23:36 +1030
Message-ID: <8761c3co4f.fsf@rustcorp.com.au>
References: <1421337370-25961-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1421337370-25961-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> If set, try legacy interface first, modern one if that fails.  Useful to
> work around device/driver bugs, and for compatibility testing.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, I've applied all these to virtio-next.

Cheers!
Rusty.
