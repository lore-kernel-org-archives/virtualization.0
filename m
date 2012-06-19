From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] block: Introduce __blk_segment_map_sg() helper
Date: Tue, 19 Jun 2012 11:00:51 -0700
Message-ID: <CAOS58YOzQ-fgLMCBYC=1zg=mXTmb96YcueNc3pu+ZLZVo1Xj7Q@mail.gmail.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-2-git-send-email-asias@redhat.com>
	<20120618213103.GC32733@google.com> <4FDFDDBE.3050506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDFDDBE.3050506@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Mon, Jun 18, 2012 at 7:02 PM, Asias He <asias@redhat.com> wrote:
>> I *hope* this is a bit prettier. =A0e.g. Do we really need to pass in
>> @sglist and keep using "goto new_segment"?
>
> I think this deserves another patch on top of this splitting one. I'd like
> to clean this up later.

Yeap, doing it in a separate patch would be better. It would be great
if you can include such patch in this series. :)

Thanks.

-- =

tejun
