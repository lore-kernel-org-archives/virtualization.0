From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 08 Jan 2008 10:43:14 -0600
Message-ID: <4783A822.6000204__1867.57954438708$1199810760$gmane$org@codemonkey.ws>
References: <20080108153356.GA21726@dmt>
	<478399D5.9030707@codemonkey.ws>	<20080108161005.GA22168@dmt>
	<4783A14A.3080605@codemonkey.ws> <4783A68E.80901@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4783A68E.80901@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> BTW, I don't think the target should be a config value.  You don't 
>> gain anything from it being in the config space and it's somewhat 
>> unnatural for a virtio device.  It makes more sense as a message to 
>> the guest.
>>   
>
> I disagree. The target is state, not an individual item that needs to 
> be acted on. Having it as a single variable means that multiple 
> changes are collapsed automatically, and that the the setting survives 
> module reload.
>
> It's like a volume control, it doesn't send messages when you turn it, 
> it just sets a value.

It's a value that is meant to be acted upon though, not something to be 
polled.  You want to tell the driver that it should now try to balloon 
to a certain value.  Or maybe not.  Maybe the driver should read the 
target from the config space but then have a "kick" message that tells 
it, hey, something's probably changed.

> (maybe a thermostat knob is a better analogy, with the driver being 
> the circuitry around the knob that tries to control the temperature to 
> match the setting)

FWIW, I'm pretty sure that most modern volume controls are actually 
button presses for either direction instead of a variable resistor but 
point taken ;-)

> I believe state-like controls will be useful for other settings, like 
> ethernet link state.

It's difficult with the current config interface since it treats 
everything as a discrete blob that is updated all at once.  I'm not 
really sure how to proceed.

Rusty: do you have an opinion here?

Regards,

Anthony Liguori
