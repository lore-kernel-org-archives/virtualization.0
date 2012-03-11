From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Sun, 11 Mar 2012 13:42:31 +0300
Message-ID: <20120311104230.GC3337@mwanda>
References: <1331422300-4330-1-git-send-email-kys@microsoft.com>
	<1331422331-4381-1-git-send-email-kys@microsoft.com>
	<1331422331-4381-2-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2086371817=="
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1331422331-4381-2-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@linuxfoundation.org, ohering@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Alan Stern <stern@rowland.harvard.edu>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2086371817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 10, 2012 at 03:32:09PM -0800, K. Y. Srinivasan wrote:
> +		switch (message->kvp_hdr.operation) {
> +		case KVP_OP_SET:
> +			switch (in_msg->body.kvp_set.data.value_type) {
> +			case REG_SZ:
> +				/*
> +				 * The value is a string - utf16 encoding.
> +				 */
> +				message->body.kvp_set.data.value_size =
> +				utf16s_to_utf8s(
> +				(wchar_t *)
> +				in_msg->body.kvp_set.data.value,
> +				in_msg->body.kvp_set.data.value_size,
> +				UTF16_LITTLE_ENDIAN,
> +				message->body.kvp_set.data.value,
> +				HV_KVP_EXCHANGE_MAX_VALUE_SIZE) + 1;
> +				break;
> +

This block of unreadable text is so nasty.

You could return directly if the msg = kmalloc() fails and pull
everything in one indent level.  It's normally more readable to
handle errors as soon as possible anyway.

Probably that's not enough to make a difference and we'd need to
introduce a new function.

Btw I don't know if utf16s_to_utf8s() counts the NUL char or not.
It feels like maybe we could end up with ->value_size equal to
HV_KVP_EXCHANGE_MAX_VALUE_SIZE + 1.

regards,
dan carpenter

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXIGWAAoJEOnZkXI/YHqRewIP/2FCLwjqyq4tApTNDfAmUqD1
G6EvsQpOjUuYcev8ZWbQ/6Dw6572vMy+DIiOXyFWG9HATGcSUaPl1KP2cCemOAHk
ycccaUP2xX5NM8rNREHxKHmCucRC+roZ1Ml1DcyQ/ftsyIJ8Se8trT55+u4DlwOD
Pm7rNZnQedtkr5OqWd0+LwbJFYeso3tqQHplPg2XAycx4uqSqsJK8HCbyMSBU+tR
Wfzd9f8Ml4SeHIFevVa1cEuWnHRipn9/ItGIgZ3yrcL7/Kv2LeKjCt8oiN8F7Yxg
Pi+kaSKKzU/XA50JsmIG9f5eY0gfTUNJ2wyQp62V6dMtqWp6PlupLBhDtgET1jMI
OciMuqxfmqhCgatqiZM3w1FHgnL7gYYST66Myoj5f2hBJ8aqZGhk2ok5aDrXHs55
wuIJ2MXyaDL8dhqY8C2Hj6FgJE3A9OnKBoD0p92Y+xwimfv8Bvh6XDdWnvUw1nSw
mApJBc1qCqo8LBbpCSSNVA5NvUIL/Fp62K2CCd8Kr0aGpP7plGmj/HV2yYG7lWPP
KwL2fOc3zysYO74g6z+xkD/bnWfZQ7awPSn3K5fmHG4J0qwYj0GnyKa0MEytOO8K
jtc+p7uO3YPvrxkskd7qtTYhYqLEi4Hc0pZEjuyVhMcioEXP6/QPVPp4pn/2XEHQ
tKK99ecllA4/qoSaU0HT
=Q0vO
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--===============2086371817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--===============2086371817==--
