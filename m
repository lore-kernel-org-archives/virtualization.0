From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH RFC 1/7] virtio: relax feature check
Date: Tue, 12 May 2015 14:49:59 +0100
Message-ID: <CAFEAcA9b1sJoPr=XToMUJdN=tjvtuYC1hPyPQ1b5PcSbcsXZfw__43413.7414129966$1431440555$gmane$org@mail.gmail.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120737.8607.30158.stgit@bahia.huguette.org>
	<20150512151453.42880d6c.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150512151453.42880d6c.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12 May 2015 at 14:14, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Wed, 06 May 2015 14:07:37 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
>> @@ -233,7 +233,6 @@ static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
>>
>>  static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
>>  {
>> -    assert(fbit < 32);
>>      return !!(features & (1 << fbit));
>>  }
>>
>>
>>
>
> I must say I'm not very comfortable with knowingly passing out-of-rage
> values to this function.

It would invoke C undefined behaviour, so clearly a bug if we did
pass an out-of-range value here. You'd need to at least do
    if (fbit >= 32) {
        return false;
    }
if you want to make it valid.

-- PMM
