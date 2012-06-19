From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 0/3] Improve virtio-blk performance
Date: Tue, 19 Jun 2012 11:14:26 +0100
Message-ID: <CAJSP0QWcRbUPqY5dhEp00p0HKx_vaH-Hbn7gfoaQrjLvPt01=g@mail.gmail.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<CAJSP0QXOn-5Krm6hSMmm=zRYkG43k9F4Xe6P+ENMFtgMhTupFA@mail.gmail.com>
	<4FDEF73E.3010501@redhat.com>
	<CAJSP0QXj0brxkTRGCMcjYU3AZwFbk+O5D2ATNz8GLECt9rNs7w@mail.gmail.com>
	<4FDFFEF8.9000609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDFFEF8.9000609@redhat.com>
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

On Tue, Jun 19, 2012 at 5:24 AM, Asias He <asias@redhat.com> wrote:
> On 06/18/2012 06:58 PM, Stefan Hajnoczi wrote:
>>
>> As long as the latency is decreasing that's good. =A0But It's worth
>> keeping in mind that these percentages are probably wildly different
>> on real storage devices and/or qemu-kvm. =A0What we don't know here is
>> whether this bottleneck matters in real environments - results with
>> real storage and with qemu-kvm would be interesting.
>
>
> Yes. Here is the performance data on a Fusion-IO SSD device.
>
> Fio test is performed in a 8 vcpu guest with Fusion-IO based guest using =
kvm
> tool.
>
> =A0 =A0Short version:
> =A0 =A0 With bio-based IO path, sequential read/write, random read/write
> =A0 =A0 IOPS boost =A0 =A0 =A0 =A0 : 11%, 11%, 13%, 10%
> =A0 =A0 Latency improvement: 10%, 10%, 12%, 10%

Nice, I'm glad the improvement shows on real hardware.

Stefan
