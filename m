From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 00/31] virtio: console: Fixes,
	multiple devices and generic ports
Date: Wed, 23 Dec 2009 17:09:28 +1030
Message-ID: <200912231709.28442.rusty@rustcorp.com.au>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 23 Dec 2009 01:04:10 am Amit Shah wrote:
> Hey Rusty,
> 
> This series adds support for generic ports with each port getting two
> vqs: one for input and one for output. The host notifies us via the
> config space of the max. number of ports that can be added for a
> particular device.

Hi Amit,

   I've just started a couple of weeks' leave, but I'll try to review these
in the last week of this year.

Thanks,
Rusty.
