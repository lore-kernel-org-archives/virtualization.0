From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: v3.18-rc1 32 bit KVM hangs early in boot process
Date: Tue, 21 Oct 2014 12:40:10 -0400
Message-ID: <CA+5PVA5MCRhwnkbNXpMmLzeM4G=aau0kuRU_wma-5T59M+2vkA@mail.gmail.com>
References: <5445479C.4030201@gmx.de>
	<5446858B.3040107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5446858B.3040107@gmx.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 21, 2014 at 12:10 PM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
> On 10/20/2014 07:34 PM, Toralf F=F6rster wrote:
>> I uploaded the screen shots from the virt-manager to [1] and [2]
>>
>> FWIW e56d9fccb was fine so the bug slipped in after that.
>>
>
>>
>> [1] http://www.directupload.net/file/d/3781/j9mwrtpq_jpg.htm
>> [2] http://www.directupload.net/file/d/3781/29trc56v_jpg.htm
>>
> It might be virtio-console related, when the uevetns are processed:
>
> http://www.directupload.net/file/d/3782/6lg5yihh_jpg.htm

Try
http://mid.gmane.org/1413813529-11044-1-git-send-email-cornelia.huck@de.ibm=
.com

josh
