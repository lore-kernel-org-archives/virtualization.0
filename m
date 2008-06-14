From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio: Complete feature negotation before updating
	status
Date: Sat, 14 Jun 2008 14:13:08 +1000
Message-ID: <200806141413.09036.rusty__21738.0531285473$1213417011$gmane$org@rustcorp.com.au>
References: <1213361201-10854-1-git-send-email-markmc@redhat.com>
	<1213361201-10854-2-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213361201-10854-2-git-send-email-markmc@redhat.com>
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
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 13 June 2008 22:46:41 Mark McLoughlin wrote:
> lguest (in rusty's use-tun-ringfd patch) assumes that the
> guest has updated its feature bits before setting its status
> to VIRTIO_CONFIG_S_DRIVER_OK.
>
> That's pretty reasonable, so let's make it so.

Applied.  That's a bug, I'll send to Linus immediately (I screwed up in the 
feature changes which are new in this kernel).

Thanks for catching this,
Rusty.
