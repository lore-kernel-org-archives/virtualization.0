From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 08 Jan 2008 18:36:30 +0200
Message-ID: <4783A68E.80901__42258.588030427$1199810629$gmane$org@qumranet.com>
References: <20080108153356.GA21726@dmt>
	<478399D5.9030707@codemonkey.ws>	<20080108161005.GA22168@dmt>
	<4783A14A.3080605@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4783A14A.3080605@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> BTW, I don't think the target should be a config value.  You don't gain 
> anything from it being in the config space and it's somewhat unnatural 
> for a virtio device.  It makes more sense as a message to the guest.
>   

I disagree. The target is state, not an individual item that needs to be 
acted on. Having it as a single variable means that multiple changes are 
collapsed automatically, and that the the setting survives module reload.

It's like a volume control, it doesn't send messages when you turn it, 
it just sets a value.

(maybe a thermostat knob is a better analogy, with the driver being the 
circuitry around the knob that tries to control the temperature to match 
the setting)

I believe state-like controls will be useful for other settings, like 
ethernet link state.

-- 
error compiling committee.c: too many arguments to function
