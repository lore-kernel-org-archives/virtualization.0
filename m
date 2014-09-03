From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] virtio_net: pass well-formed sgs to virtqueue_add_*()
Date: Tue, 2 Sep 2014 21:54:11 -0700
Message-ID: <CALCETrUv4_p2drPJBbs901+Kq-86rOSUzQu1DrkvJyCLvmz9nQ__16749.7059949257$1409720091$gmane$org@mail.gmail.com>
References: <1409718556-3041-1-git-send-email-rusty@rustcorp.com.au>
	<1409718556-3041-2-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409718556-3041-2-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev <netdev@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 2, 2014 at 9:29 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> This is the only driver which doesn't hand virtqueue_add_inbuf and
> virtqueue_add_outbuf a well-formed, well-terminated sg.  Fix it,
> so we can make virtio_add_* simpler.

OK, I get it now: you're reinitializing the table every time, clearing
old end marks.  There's room to microoptimize this, but it's probably
not worth it.

IOW, looks good to me.

--Andy
