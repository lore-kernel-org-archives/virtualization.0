From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/7] virtio: console: Fixes,
	new flexible way of discovering ports
Date: Tue, 30 Mar 2010 15:46:14 +1030
Message-ID: <201003301546.14309.rusty@rustcorp.com.au>
References: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>
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
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 23 Mar 2010 07:27:53 pm Amit Shah wrote:
> Hello all,
> 
> This new patchset switches over to using the control queue for port
> discovery so that we can stay in sync with the host for port
> enumeration and also don't use bitmaps to limit us to config space
> sizes.
> 
> This changes the ABI, so it would be better to merge this for 2.6.34
> so that we don't have to worry about released kernels with the older
> ABI.

This looks horribly like development during the merge window.

Sorry,
Rusty.
