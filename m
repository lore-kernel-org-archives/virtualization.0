From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] Drivers: hv: Support the newly introduced KVP
 messages in the driver
Date: Fri, 16 Mar 2012 08:45:56 +0300
Message-ID: <20120316054556.GH3163@mwanda>
References: <1331858893-775-1-git-send-email-kys@microsoft.com>
 <1331858925-827-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331858925-827-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, Alan Stern <stern@rowland.harvard.edu>
List-Id: virtualization@lists.linuxfoundation.org


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 05:48:43PM -0700, K. Y. Srinivasan wrote:
>  	/*
>  	 * The windows host expects the key/value pair to be encoded
>  	 * in utf16.
>  	 */
>  	keylen = utf8s_to_utf16s(key_name, strlen(key_name), UTF16_HOST_ENDIAN,
> -				(wchar_t *) kvp_data->data.key,
> +				(wchar_t *) kvp_data->key,
>  				HV_KVP_EXCHANGE_MAX_KEY_SIZE / 2);
> -	kvp_data->data.key_size = 2*(keylen + 1); /* utf16 encoding */
> +	kvp_data->key_size = 2*(keylen + 1); /* utf16 encoding */
> +

I feel like a jerk for asking this, but is the output length correct
here?  It seems like we could go over again.  Also utf8s_to_utf16s()
can return negative error codes, why do we ignore those?

regards,
dan carpenter


--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYtOUAAoJEOnZkXI/YHqRjV0QAIPTy1YYOfgNaGAt7TZymW37
2H53XbR2JVVA/P0KlmtdJonP2Ri+f8OrXGifAnUuJA7SOaVCG1tMVjnGWdgJNXVZ
AO8lov46QWvTJf+oCPD6ayi5hkGZvQy5oTFeLQ5jOcwt0gbE4k/JbJ7syTjz4Q1G
mhrTj7RFxziBCXKA+z4xLCrUDGsLvoCq0t2K4zjT8eHsl3LFkm84cWQpGOkS7P/m
DyeSQGCIUftIr4YUBGgDXZ+276HA1fA5KJP7xupPfbHKR+VPBsTStqkDTL1bqt5q
FbcB7HHO42ZcHMsICoEJ64wOWo+SZ2KCcGHXq1e8aLOa1q8hNuZmmmPOdATvVJgp
CYSRpTTUC74ns8qjAfGMNmgQTitE9BCtbThrK2NKfzM7kxX7v6h/hSdR820Sw7uE
b5suZdaQFJeLQ1Z4Fih1Y4d9UQUZLaZq2omEP14eoLdsraFuPQfbJ0OEGCZgs6bj
9KMXoz3bZz1kg8k5F0uIZ3dlAHyuU92Fk1CPjR+4Dac3QmrNtT2QJeLXbJXivGDG
tCqM0De25GLJdOdKYhbZN0t7/ZvuUPqFPnyCHfn6CF5dpptjJ6VERpDJfyK3MzLt
+Dfl4hxNgevSsyimJ1UIZYpVYNj+u6iHKq7ieJc4+G+wKk3m5bnTIF+I45dldOaX
Gx5vmJvTJEgByNCD60UF
=S/9j
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--
