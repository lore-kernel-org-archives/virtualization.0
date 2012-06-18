From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 0/3] Improve virtio-blk performance
Date: Mon, 18 Jun 2012 10:14:09 +0100
Message-ID: <CAJSP0QXOn-5Krm6hSMmm=zRYkG43k9F4Xe6P+ENMFtgMhTupFA@mail.gmail.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1340002390-3950-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 18, 2012 at 7:53 AM, Asias He <asias@redhat.com> wrote:
> Fio test shows it gives, 28%, 24%, 21%, 16% IOPS boost and 32%, 17%, 21%, 16%
> latency improvement for sequential read/write, random read/write respectively.

Sounds great.  What storage configuration did you use (single spinning
disk, SSD, storage array) and are these numbers for parallel I/O or
sequential I/O?

What changed since Minchan worked on this?  I remember he wasn't
satisfied that this was a clear win.  Your numbers are strong so
either you fixed something important or you are looking at different
benchmark configurations.

Stefan
