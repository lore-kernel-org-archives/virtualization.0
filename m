From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 0/2] virtio: provide a way for host to monitor critical
	events in the device
Date: Tue, 24 Jul 2012 14:25:44 +0930
Message-ID: <87a9yprc4v.fsf@rustcorp.com.au>
References: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, penberg@kernel.org, asias.hejun@gmail.com
Cc: kvm@vger.kernel.org, wency@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, anthony@codemonkey.ws, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 23 Jul 2012 22:32:39 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> As it was discussed recently, there's currently no way for the guest to notify
> the host about panics. Further more, there's no reasonable way to notify the
> host of other critical events such as an OOM kill.

I clearly missed the discussion.  Is this actually useful?  In practice,
won't you want the log from the guest?  What makes a virtual guest
different from a physical guest?

Guest watchdog functionality might be useful, but that's simpler to
implement via a virtio watchdog device, and more effective to implement
via a host facility that actually pings guest functionality (rather than
the kernel).

Cheers,
Rusty.
