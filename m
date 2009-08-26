From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Wed, 26 Aug 2009 16:57:18 +0530
Message-ID: <20090826112718.GA11117__19113.8453702026$1251286349$gmane$org@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
> 
> Hello all,
> 
> Here is a new iteration of the patch series that implements a
> transport for guest and host communications.
> 
> The code has been updated to reuse the virtio-console device instead
> of creating a new virtio-serial device.

And the problem now is that hvc calls the put_chars function with
spinlocks held and we now allocate pages in send_buf(), called from
put_chars.

A few solutions:
- Keep things as they are, virtio_console.c remains as it is and
  virtio_serial.c gets added

- Have separate write paths for console devices in virtio_console.c,
  which would beat the purpose of merging the two drivers and then
  they'd be better off standalone

- Convert hvc's usage of spinlocks to mutexes. I've no idea how this
  will play out; I'm no expert here. But I did try doing this and so far
  it all looks OK. No lockups, lockdep warnings, nothing. I have full
  debugging enabled. But this doesn't mean it's right.

Comments?

		Amit
