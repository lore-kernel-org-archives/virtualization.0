From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 18/31] virtio: console: Buffer data that comes from the
	host
Date: Mon, 4 Jan 2010 15:17:17 +0530
Message-ID: <20100104094717.GA11485@amit-x200.redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-18-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-19-git-send-email-amit.shah@redhat.com>
	<201001041945.30841.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001041945.30841.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Jan 04 2010 [19:45:30], Rusty Russell wrote:
> On Wed, 23 Dec 2009 01:04:28 am Amit Shah wrote:
> > The console could be flooded with data from the host; handle this
> > situation by buffering the data.
> 
> Is this still true?  If we only add_buf when we're ready, surely the host
> can't flood us with one virtqueue per port?

I guess I meant something completely different. This message is
definitely misleading and I'll re-word it.

You're right; we don't need the 'guest throttling' feature that was
needed earlier.

Thanks!

		Amit
