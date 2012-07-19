From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND 5/5] vhost-blk: Add vhost-blk support
Date: Thu, 19 Jul 2012 16:09:57 +0300
Message-ID: <20120719130957.GD9303@redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
	<1342169711-12386-6-git-send-email-asias@redhat.com>
	<87mx2vrjdl.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mx2vrjdl.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 19, 2012 at 08:05:42AM -0500, Anthony Liguori wrote:
> Of course, the million dollar question is why would using AIO in the
> kernel be faster than using AIO in userspace?

Actually for me a more important question is how does it compare
with virtio-blk dataplane?

-- 
MST
