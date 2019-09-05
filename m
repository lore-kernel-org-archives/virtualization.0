From: Jaak Ristioja <jaak@ristioja.ee>
Subject: Re: Xorg indefinitely hangs in kernelspace
Date: Thu, 5 Sep 2019 15:34:12 +0300
Message-ID: <e4b7d889-15f3-0c90-3b9f-d395344499c0__39110.6557844736$1567686861$gmane$org@ristioja.ee>
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
	<20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05.09.19 10:14, Gerd Hoffmann wrote:
> On Tue, Aug 06, 2019 at 09:00:10PM +0300, Jaak Ristioja wrote:
>> Hello!
>>
>> I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
>> I originally filed the issue on LaunchPad and more details can be found
>> there, although I doubt whether these details are useful.
> 
> Any change with kernel 5.3-rc7 ?

Didn't try. Did you change something? I could try, but I've done so
before and every time this bug manifests itself with MAJOR.MINOR-rc# I
get asked to try version MAJOR.(MINOR+1)-rc# so I guess I could as well
give up?

Alright, I'll install 5.3-rc7, but once more it might take some time for
this bug to expose itself.

One thing to note though, is that this occurred much more often with
older kernels (or older versions of the Kubuntu desktop/Firefox in my
VM), sometimes even several times in an hour of use.


Best regards,
J
