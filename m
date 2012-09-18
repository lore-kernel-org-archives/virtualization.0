From: Laszlo Ersek <lersek@redhat.com>
Subject: miscalculated vring size in virtio-0.9.5.pdf?
Date: Tue, 18 Sep 2012 23:49:57 +0200
Message-ID: <5058EC85.5080402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

the vring_size() formula in section 2.3 seems to miss

(a) "vring_avail.used_event" in the first ALIGN(), and

(b) "vring_used.flags", "vring_used.idx", "vring_used.avail_event" in
the second ALIGN().

vring_size() in Appendix A fixes (b) (no rounding up to page size
though), but (a) is wrong there too, I believe.

Thanks,
Laszlo
