From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 0/3] Improve virtio-blk performance
Date: Mon, 18 Jun 2012 11:58:54 +0100
Message-ID: <CAJSP0QXj0brxkTRGCMcjYU3AZwFbk+O5D2ATNz8GLECt9rNs7w@mail.gmail.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<CAJSP0QXOn-5Krm6hSMmm=zRYkG43k9F4Xe6P+ENMFtgMhTupFA@mail.gmail.com>
	<4FDEF73E.3010501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDEF73E.3010501@redhat.com>
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

On Mon, Jun 18, 2012 at 10:39 AM, Asias He <asias@redhat.com> wrote:
> On 06/18/2012 05:14 PM, Stefan Hajnoczi wrote:
>>
>> On Mon, Jun 18, 2012 at 7:53 AM, Asias He <asias@redhat.com> wrote:
>>>
>>> Fio test shows it gives, 28%, 24%, 21%, 16% IOPS boost and 32%, 17%, 21=
%,
>>> 16%
>>> latency improvement for sequential read/write, random read/write
>>> respectively.
>>
>>
>> Sounds great. =A0What storage configuration did you use (single spinning
>> disk, SSD, storage array) and are these numbers for parallel I/O or
>> sequential I/O?
>
>
> I used ramdisk as the backend storage.

As long as the latency is decreasing that's good.  But It's worth
keeping in mind that these percentages are probably wildly different
on real storage devices and/or qemu-kvm.  What we don't know here is
whether this bottleneck matters in real environments - results with
real storage and with qemu-kvm would be interesting.

Stefan
