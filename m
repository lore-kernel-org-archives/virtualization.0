From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/5] virtio: make virtqueue_add_buf() returning 0 on
	success, not capacity.
Date: Wed, 17 Oct 2012 00:19:28 +1030
Message-ID: <87ehkyplw7.fsf@rustcorp.com.au>
References: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
	<1350394252-23934-5-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350394252-23934-5-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Note: I also have minor cleanups to virtio drivers to change (ret >= 0)
to (ret == 0) where it would otherwise be confusing for new readers, but
I didn't clutter the list with them.  See my virtio-wip tree for the
gory details.

Cheers,
Rusty.
