From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Fri, 28 Sep 2012 10:32:22 +0200
Message-ID: <20120928083222.GA5848@redhat.com>
References: <1348540577-7474-1-git-send-email-asias@redhat.com>
	<5061BAED.9020205@redhat.com> <87ehlo497o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ehlo497o.fsf@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 27, 2012 at 09:40:03AM +0930, Rusty Russell wrote:
> I forgot about the cool hack which MST put in to defer event updates
> using disable_cb/enable_cb.

I considered sticking some invalid value
in event index on disable but in my testing it did not seem to
give any gain, and knowing actual index of the other side
is better for debugging.

-- 
MST
