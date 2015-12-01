From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] Input: Remove vmmouse port reservation
Date: Tue, 1 Dec 2015 15:52:37 -0800
Message-ID: <CAKdAkRSSYTWWoTdcw+dsgNDNd1QrngQZRd_3x4UT03sFYs3O8g@mail.gmail.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-4-git-send-email-syeh@vmware.com>
	<CAKdAkRTHPSKOePts8cKAHc+PLAgN83skhfPqoDZUvoPXae5-pQ@mail.gmail.com>
	<20151201230422.GA11239@syeh-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151201230422.GA11239@syeh-linux>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 1, 2015 at 3:04 PM, Sinclair Yeh <syeh@vmware.com> wrote:
> Hi,
>
> On Tue, Dec 01, 2015 at 02:30:05PM -0800, Dmitry Torokhov wrote:
>> Hi Sinclair,
>>
>> On Tue, Dec 1, 2015 at 2:18 PM, Sinclair Yeh <syeh@vmware.com> wrote:
>> > Port reservation is not required.
>>
>> You need to expand on why we do not need to reserve port.
>
> Thomas gave me this input earlier, too, so I added the one liner.
>
> There was a long discussion on accessing the port a few years ago:
> https://lkml.org/lkml/2008/9/24/512
>
>>
>> > Furthermore, this port is shared
>> > by other VMware services for host-side communication.
>>
>> What services would that be? Do they reserve the port?
>
> This port is used by quite a few guest-to-host communication capabilities,
> e.g. getting configuration, logging, etc.  Currently multiple kernel
> modules, and one or more priviledged guest user mode app, e.g.
> open-vmware-tools, use this port without reservation.

Ah, I forgot that vmmouse does not have a dedicated port...

>
> After some internal discussions, it was determined that no reservation
> is required when accessing the port in this manner.
>
> Do you want me to put the above in the commit message?

Not about the bit about "internal discussions", but the rest - yes please.

-- 
Dmitry
